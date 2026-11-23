#!/usr/bin/env bash

# Exit right away if there are any errors (e.g. yq or another tool isn't installed)
set -e

mod_name="Mini Civ 5"
mod_version=$(yq -p xml -oy ".Mod.+@version" "src/${mod_name}.modinfo")
export mod_name_version="$(echo "${mod_name} (v ${mod_version})" | tr '[:upper:]' '[:lower:]')"

echo "Updating mod file checksums ..."
pushd src > /dev/null
# Override IFS (internal field separator) in order to handle files with spaces in name
original_IFS="$IFS"
IFS=$'\n'
for filename in $(find . -type f | cut -c 3-); do
    new_md5sum=$(md5sum "$filename" | awk '{print $1}')
    old_md5sum=$(grep "$filename" "${mod_name}.modinfo" | head -n 1 | awk '{print $2}' | cut -c 6- | rev | cut -c 2- | rev)
    if [[ -n $old_md5sum ]]; then
        # -r allows references like \1 to be used without escaping parenthesis
        sed -i -r "s@${old_md5sum}(.*${filename})@${new_md5sum}\1@" "${mod_name}.modinfo"
    fi
done
IFS="$original_IFS"
popd > /dev/null

# Clean up previous mod package
rm -f "${mod_name_version}.civ5mod"

# Create the mod package
temp_dir=$(mktemp -d -p $(pwd))
cp -ar src/. "${temp_dir}"
pushd "${temp_dir}" > /dev/null
mv "${mod_name}.modinfo" "${mod_name_version}.modinfo"
# Lower-case all file names for cross-platform compatibility, particularly Linux (https://stackoverflow.com/a/152741)
find . -depth -name '*[A-Z]*'|sed -n 's/\(.*\/\)\(.*\)/mv -n -T "\1\2" "\1\L\2"/p'|sh
7z a -r ../"${mod_name_version}.civ5mod" *
popd > /dev/null
rm -rf "${temp_dir}"
