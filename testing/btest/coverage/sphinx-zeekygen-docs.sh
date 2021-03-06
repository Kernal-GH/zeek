# This script checks whether the reST docs generated by zeekygen are stale.
# If this test fails when testing the master branch, then simply run:
#
#     testing/scripts/update-zeekygen-docs.sh
#
#  and then commit the changes.
#
# @TEST-EXEC: bash $SCRIPTS/update-zeekygen-docs.sh ./doc
# @TEST-EXEC: bash %INPUT

if [ -n "$TRAVIS_PULL_REQUEST" ]; then
    if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
        # Don't run this test on Travis for pull-requests, just let someone
        # manually update zeek-docs for things when merging to master.
        exit 0
    fi
fi

function check_diff
    {
    local file=$1
    echo "Checking $file for differences"
    diff -Nru $DIST/$file $file 1>&2

    if [ $? -ne 0 ]; then
        echo "============================" 1>&2
        echo "" 1>&2
        echo "$DIST/$file is outdated" 1>&2
        echo "" 1>&2
        echo "You can ignore this failure if testing changes that you will" 1>&2
        echo "submit in a pull-request." 1>&2
        echo "" 1>&2
        echo "If this fails in the master branch or when merging to master," 1>&2
        echo "re-run the following command:" 1>&2
        echo "" 1>&2
        echo "    $SCRIPTS/update-zeekygen-docs.sh" 1>&2
        echo "" 1>&2
        echo "Then commit/push the changes in the zeek-docs repo" 1>&2
        echo "(the doc/ directory in the zeek repo)." 1>&2
        exit 1
    fi
    }

for file in $(find ./doc -name autogenerated-*); do
    check_diff $file
done

check_diff ./doc/scripts
