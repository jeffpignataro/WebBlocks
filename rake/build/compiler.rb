require 'pathname'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/util.rb"

module WebBlocks
  
  module Build
    
    class Compiler
      
      attr_accessor :config
      attr_accessor :dir_build_temp
      attr_accessor :dir_src
      attr_accessor :dir_build_temp_sass
      
      def initialize(config)
        @config = config
        @dir_build_temp = WebBlocks::Util.dir_from_root_through_dir_stack @config[:build][:dir_tmp] 
        @dir_build_temp_sass = "#{dir_build_temp}/sass"
        @dir_src = WebBlocks::Util.dir_from_root_through_dir_stack @config[:src][:dir]
      end

      def get_modules dir, recursive = true
        mods = []
        Dir.entries(dir).each do |name|
          next if name[0,1] == '.'
          path = "#{dir}/#{name}"
          if File.directory? path
            if recursive
              get_modules(path, recursive).each do |sub|
                mods.push sub
              end
            else
              mods.push path
            end
          elsif WebBlocks::Util.file_ext? name, ['scss', 'js']
            name = name.sub /\.(scss|js)$/, ''
            name = name.sub /^\_/, ''
            mods.push "#{dir}/#{name}"
          end
        end
        mods
      end
      
      def get_files dir, ext = false, recursive = true
        files = []
        Dir.entries(dir).each do |name|
          next if name[0,1] == '.'
          path = "#{dir}/#{name}"
          if File.directory? path
            if recursive
              get_files(path, ext, recursive).each do |sub|
                files.push sub
              end
            elsif !ext
              files.push path
            end
          elsif WebBlocks::Util.file_ext? name, ext
            files.push "#{dir}/#{name}"
          end
        end
        files
      end
      
    end
    
  end
  
end