# @TEST-EXEC: ${DIST}/aux/zeek-aux/plugin-support/init-plugin -u . Testing WithPatchVersion
# @TEST-EXEC: cp -r %DIR/plugin-withpatchversion-plugin/* .
# @TEST-EXEC: ./configure --bro-dist=${DIST} && make
# @TEST-EXEC: ZEEK_PLUGIN_PATH=$(pwd) zeek -N Testing::WithPatchVersion >> output
# @TEST-EXEC: btest-diff output
