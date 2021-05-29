
function __setup_project_shared
	set -l project_name $argv[1]
	set -l template_path (dirname (dirname $fish_function_src_path))/templates

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
end

function __setup_kotlin_project
	set -l template_path (dirname (dirname $fish_function_src_path))/templates
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

	echo "Generating gradle wrapper"
	gradle wrapper --gradle-version=7.0.2
	git add gradle
	git add gradlew
	git add gradlew.bat

	echo Running (set_color $fish_color_command)./gradlew (set_color $fish_color_param)test (set_color normal)
	./gradlew run

	echo Committing
	git commit -m "Set-up Kotlin project"
end

function __setup_typescript_project

end

function __setup_typescript_lua_project

end

function setup_project
	set -l mode $argv[1]
	set -l name (basename $PWD)

	switch $mode
		case kotlin
			echo Setting up Kotlin project "'$name'"
			__setup_project_shared $name
			__setup_kotlin_project $name
		case typescript
			echo Setting up TypeScript project "'$name'"
			__setup_project_shared $name
			__setup_typescript_project $name
		case typescript-lua
			echo Setting up Lua TypeScript project "'$name'"
			__setup_project_shared $name
			__setup_typescript_lua_project $name
		case '*'
			echo Unknown mode "'$mode'"
	end
end
