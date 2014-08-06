# script clones git repo and calls rake in it's local copy

require 'albacore'

@env_repo_path = ENV['repopath']
@env_branch = ENV['branch']

task :default => [:cloneRepo]

def targetBranch
	if @env_branch.nil? || @env_branch == ""
		puts "branch defaulted to \"master\""
		"master"
	elsif
		@env_branch
	end
end

def targetFolder
	if @env_repo_path.nil? || @env_repo_path == ""
		puts "repopath is nil"
	end

	regexstr = /\w+$/
	match = @env_repo_path.match regexstr

	if(match[0].nil?)
		puts "match is nil"
	end

	match[0]  + ".#{targetBranch}"
end

desc "clone repository to folder with name {last part of repo path}.{branch name}"
task :cloneRepo do

	puts "git clone #{@env_repo_path} --branch #{targetBranch} --single-branch ./#{targetFolder}"

	system("git clone #{@env_repo_path} --branch #{targetBranch} --single-branch ./#{targetFolder}")

    if File.exists?("./#{targetFolder}/rakefile.rb")
      puts "calling project rake file ..."
	  Dir.chdir(targetFolder) do
	      system("rake");
	  end      
    end    

    puts "done."
end