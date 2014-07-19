#!/bin/bash

####### @author Bhargav Vadher   ########################
####### @version V1.0 2014-07-17 ########################
####### @license WTFPL (http://www.wtfpl.net/) ##########

# arguments check
if [[ $# -lt 2 ]]; then
	echo "Need at least two arguments";
	echo "      Usage    : ./findMostCommittedFiles.sh {lookup_dir} {top_count_per_file} [,{comma_separated_file_types}]";
	echo
	echo "      Example1 : ./findMostCommittedFiles.sh /www/bvadher/branches/chegg-web/vendor/chegg/core 10 js,scss,php";
	echo "      Example2 : ./findMostCommittedFiles.sh /www/bvadher/branches/chegg-web/vendor/chegg/core 10";
	exit 1;
fi

LOOKUP_DIR="$1";
TOP_COUNT="$2";
TMP_FILE='/tmp/commit.logs.out';
TOP_FILES_COUNT=100;
FILE_TYPE_LIST="py,php,js,scss,css,feature,txt,tpl";

# make sure the lookup directory is a git repo
if [[ ! -d "$1/.git" ]]; then
	echo "$1 is not a git directory. Exiting ...";
	exit 1;
fi

# get file types from terminal param. If not provided, use all
FILE_TYPES=$([[ $3 == "" ]] && echo "${FILE_TYPE_LIST}" || echo "$3");

# convert filetypes into an array
FILE_TYPES_ARR=$(echo ${FILE_TYPES} | tr "," " ");

REGEX_TYPES_ARR='';

# create a regex for the `OR` operations on filetypes
for type in ${FILE_TYPES_ARR};
do
	REGEX_TYPES_ARR="${REGEX_TYPES_ARR[@]}|\.${type}";
done

# go to the lookup directory
cd ${LOOKUP_DIR};

# execute the git command. Note that I am only storing first 100 files because list could be a lot longer
git log --numstat --oneline --no-merges | egrep "^[0-9]+\s[0-9]+\s.*(${REGEX_TYPES_ARR})$" | awk -F" " '{ print $3 }' | sort | uniq -c | sort -nr | head -${TOP_FILES_COUNT} > ${TMP_FILE}

# print full log file message
echo
echo "Full log file is at ${TMP_FILE}";
echo

# print each files commitors
for file in `head -${TOP_COUNT} ${TMP_FILE}`;
do
	FILE=$(echo ${file} | tr -d '[0-9] ');

	if [[ "${FILE}" == "" ]]; then
		continue
	else
		# find top five contributors
		[ -f ${FILE} ] && echo "Checking: ${FILE}" && git log ${FILE} | egrep "Author: .*chegg\.com" | sort | uniq -c | sort -nr | head -5 || echo "Skipping: ${FILE} does not exist";
	fi
done