#!/usr/bin/env fish

function __init_kotlin_project
	set -l template_path ~/code/dotfiles/templates
	set -l project_name $argv[1]

	for path in $template_path/kotlin/* $template_path/kotlin/.*
		set -l local_path (echo $path | sed "s%$template_path/kotlin/%./%")
		if test ! -f $local_path
			echo Creating (set_color $fish_color_param)$local_path (set_color normal)
			cat $path | sed "s/%PROJECT_NAME%/$project_name/" > $local_path
			git add $local_path
		end
	end

	if test ! -d src
		echo Creating (set_color $fish_color_param)src (set_color normal)directory
		mkdir -p src/main/kotlin/com/exerro/$project_name
		mkdir -p src/test/kotlin/com/exerro/$project_name
		echo "package com.exerro.$project_name"\n\n"fun main() {"\n\t"println(\"Hello world! ($project_name)\")"\n"}" > src/main/kotlin/com/exerro/$project_name/main.kt
		echo "package com.exerro.$project_name"\n\n"fun main() {"\n\t"println(\"Hello world! ($project_name)\")"\n"}" > src/test/kotlin/com/exerro/$project_name/main.kt
		git add src/
	end

	if ! test -d gradle || ! test -f gradlew || ! test -f gradlew.bat
		echo "Generating gradle wrapper"
		gradle wrapper --gradle-version=7.0.2
		git add gradle
		git add gradlew
		git add gradlew.bat
	end

	echo Running (set_color $fish_color_command)./gradlew (set_color $fish_color_param)test (set_color normal)
	./gradlew run

	echo Updating (set_color $fish_color_param).gitignore (set_color normal)
	echo ".gradle" >> .gitignore
	echo "build/" >> .gitignore
	git add .gitignore

	echo Committing
	git commit -m "Set-up Kotlin project"
end

function __init_typescript_project
	set -l template_path (dirname (dirname $fish_function_src_path))/templates
	set -l project_name $argv[1]

	for path in $template_path/typescript/** $template_path/typescript/.**
		set -l local_path (echo $path | sed "s%$template_path/typescript/%./%")
		if test \( ! -f $local_path \) -a \( ! -d $path \)
			mkdir -p (dirname $local_path)
			echo Creating (set_color $fish_color_param)$local_path (set_color normal)
			cat $path | sed "s/%PROJECT_NAME%/$project_name/" > $local_path
			git add $local_path
		end
	end

	echo Running (set_color $fish_color_command)npm (set_color $fish_color_param)install
	npm install > /dev/null

	echo "Running initial build"
	npm run build > /dev/null

	echo Committing
	git add package-lock.json
	git commit -m "Set-up TypeScript project"
end

function __init_typescript_lua_project
	set -l template_path (dirname (dirname $fish_function_src_path))/templates
	set -l project_name $argv[1]

	for path in $template_path/typescript_lua/** $template_path/typescript_lua/.**
		set -l local_path (echo $path | sed "s%$template_path/typescript_lua/%./%")
		if test \( ! -f $local_path \) -a \( ! -d $path \)
			mkdir -p (dirname $local_path)
			echo Creating (set_color $fish_color_param)$local_path (set_color normal)
			cat $path | sed "s/%PROJECT_NAME%/$project_name/" > $local_path
			git add $local_path
		end
	end

	echo Running (set_color $fish_color_command)npm (set_color $fish_color_param)install
	npm install > /dev/null

	echo "Running initial build"
	npm run build > /dev/null

	echo Committing
	git add package-lock.json
	git commit -m "Set-up TypeScript Lua project"
end

function init_project --description "Initialise project contents"
	if test (dirname $PWD) != "/home/$USER/code/projects"
		printf "\u001b[31mYou don't seem to be in a project directory.\u001b[0m\n"
		return
	end

	set -l project_name (basename $PWD)
	set -l template_path ~/code/dotfiles/templates

	if test ! -d .git
		echo Running (set_color $fish_color_command)git (set_color $fish_color_param)init (set_color normal)
		git init &> /dev/null
	end

	if test ! -f README.md
		echo Generating (set_color $fish_color_param)README.md (set_color normal)
		echo "# $project_name"\n\n"TODO" > README.md
		git add README.md
	end

	if test ! -f LICENSE
		echo Generating (set_color $fish_color_param)LICENSE (set_color normal)
		cp $template_path/LICENSE LICENSE
		git add LICENSE
	end

	if test ! -f .gitignore
		echo Generating (set_color $fish_color_param).gitignore (set_color normal)
		cp $template_path/.gitignore .gitignore
		git add .gitignore
	end

	for mode in $argv
		switch $mode
			case kotlin
				echo Setting up Kotlin project "'$project_name'"
				__init_kotlin_project $project_name
			case typescript
				echo Setting up TypeScript project "'$project_name'"
				__init_typescript_project $project_name
			case typescript-lua
				echo Setting up Lua TypeScript project "'$project_name'"
				__init_typescript_lua_project $project_name
			case '*'
				echo Unknown mode "'$mode'"
		end
	end
end
