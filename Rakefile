require 'rake'
require 'pathname'
require 'fileutils'
load 'Rakefile-configure.rb'

task :check do
  if PACKAGES.include?("jquery")
    if `which make`.empty?
      fail 'make required'
    end
  end
  if `which sass`.empty?
    fail 'SASS required'
  end
  if `which uglifycss`.empty?
    if `which npm`.empty?
      fail 'uglifycss required'
    else
      fail 'uglifycss required (run "npm -g install uglifycss")'
    end
  end
  if `which uglifyjs`.empty?
    if `which npm`.empty?
      fail 'uglifyjs required'
    else
      fail 'uglifyjs required (run "npm -g install uglify-js")'
    end
  end
  puts "prerequisite check successful"
end

task :packages do
  if !`which git`.empty?
    sh "git submodule init"
    sh "git submodule update"
    pwd = Dir.pwd
    jquery_package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}"
    Dir.chdir(jquery_package_dir)
    sh "git submodule init"
    sh "git submodule update"
    Dir.chdir(pwd)
  else
    puts "cannot update git submodules because git is not installed"
  end
end

task :build => [:check, :packages] do
  
  begin
  
    mkdir DIR_BUILD_TMP

    tmp_main_css = "#{DIR_BUILD_TMP}/#{FILE_MAIN_CSS}"
    tmp_main_js = "#{DIR_BUILD_TMP}/#{FILE_MAIN_JS}"
    tmp_ie_css = "#{DIR_BUILD_TMP}/#{FILE_IE_CSS}"
    tmp_ie_js = "#{DIR_BUILD_TMP}/#{FILE_IE_JS}"

    File.open tmp_main_css, "w"
    File.open tmp_main_js, "w"
    File.open tmp_ie_css, "w"
    File.open tmp_ie_js, "w"
    
    if PACKAGES.include?("jquery")
      build_jquery(tmp_main_js)
    end

    if PACKAGES.include?("bootstrap")
      build_bootstrap(tmp_main_css, tmp_main_js)
    end

    if PACKAGES.include?("modernizr")
      build_modernizr(tmp_main_js)
    end

    if PACKAGES.include?("respond")
      build_respond(tmp_ie_js)
    end

    if PACKAGES.include?("selectivizr")
      build_selectivizr(tmp_ie_js)
    end
    
    if !File.exist?(DIR_BUILD)
      mkdir DIR_BUILD
    end

    main_css = "#{DIR_BUILD}/#{FILE_MAIN_CSS}"
    main_js = "#{DIR_BUILD}/#{FILE_MAIN_JS}"
    ie_css = "#{DIR_BUILD}/#{FILE_IE_CSS}"
    ie_js = "#{DIR_BUILD}/#{FILE_IE_JS}"

    sh "uglifycss \"#{tmp_main_css}\" > \"#{main_css}\""
    sh "uglifyjs \"#{tmp_main_js}\" --extras --unsafe >> \"#{main_js}\""
    
    sh "uglifycss \"#{tmp_ie_css}\" > \"#{ie_css}\""
    sh "uglifyjs \"#{tmp_ie_js}\" --extras --unsafe >> \"#{ie_js}\""
    
  ensure

    FileUtils.rm_rf DIR_BUILD_TMP
    
  end
  
end

task :clean do
  if File.exist?(DIR_BUILD_TMP)
    FileUtils.rm_rf DIR_BUILD_TMP
  end
  if File.exist?(DIR_BUILD)
    FileUtils.rm_rf DIR_BUILD
  end
end

task :default => [:clean, :build]


# build methods

def build_jquery(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}"
  begin
    pwd = Dir.pwd
    Dir.chdir(package_dir)
    sh "make"
    Dir.chdir(pwd)
    append_contents_to_file("#{package_dir}/dist/jquery.min.js", js_path)
  ensure
    pwd = Dir.pwd
    Dir.chdir(package_dir)
    sh "make clean"
    Dir.chdir(pwd)
  end
end

def build_bootstrap(css_path, js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["bootstrap"]}"
  sh "sass --precision 10 --load-path src/css/lib --load-path #{package_dir}/lib/ --style expanded src/css/site.scss >> \"#{css_path}\""
  sh "sass --precision 10 --load-path src/css/lib --load-path #{package_dir}/lib/ --style expanded src/css/site-responsive.scss >> \"#{css_path}\""
  PACKAGE_BOOTSTRAP_SCRIPTS.each do |script|
    append_contents_to_file("#{package_dir}/js/bootstrap-#{script}.js", js_path)
  end 
end

def build_modernizr(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["modernizr"]}"
  append_contents_to_file("#{package_dir}/modernizr.js", js_path)
end

def build_respond(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["respond"]}"
  append_contents_to_file("#{package_dir}/respond.min.js", js_path)
end

def build_selectivizr(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["selectivizr"]}"
  append_contents_to_file("#{package_dir}/selectivizr.js", js_path)
end

def append_contents_to_file(src, dst)
  puts "cat #{src} >> #{dst}"
  contents = File.read(src)
  File.open(dst, "a") do |handle|
    handle.puts contents
  end
end