#
# WebBlocks Builder Base Class
# 
# The WebBlocks::Build::Builder is a base clase used by both the WebBlocks
# builder itself in WebBlocks::Build::Blocks and by the package builders in 
# /rake/build/package including the package builder base class
# Rake::Build::Package::Builder.
# 
# This class should not be used as a builder itself as it does not respond
# to methods such as init, build, clean and reset.
#

require 'pathname'
require 'systemu'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/util.rb"

module WebBlocks
  
  module Build
    
    class Builder
      
      attr_accessor :config
      attr_accessor :log
      
      def initialize config, log
        @config = config
        @log = log
      end
        
      def dir_build
        @config[:build][:dir]
      end

      def dir_build_temp
        @config[:build][:dir_tmp]
      end

      def dir_build_temp_css
        WebBlocks::Util.file_from_root_through_dir_stack "#{@config[:build][:dir_tmp]}/css"
      end
      
      def file_build_temp_css
        "#{@config[:build][:dir_tmp]}/core.css"
      end
      
      def file_build_temp_css_ie
        "#{@config[:build][:dir_tmp]}/ie.css"
      end
      
      def file_build_temp_js
        "#{@config[:build][:dir_tmp]}/core.js"
      end
      
      def file_build_temp_js_ie
        "#{@config[:build][:dir_tmp]}/ie.js"
      end
      
      def dir_build_temp_js
        "#{@config[:build][:dir_tmp]}/script"
      end
      
      def dir_build_temp_img
        "#{@config[:build][:dir_tmp]}/img"
      end

      def dir_build_metadata
        @config[:build][:dir_metadata]
      end
      
      def append_contents_to_file src, dst
        WebBlocks::Util.append_contents_to_file src, dst
      end
      
      def append_compressed_css_to_file src, dst
        status, stdout, stderr = systemu "#{@config[:exec][:uglifycss]} \"#{src}\" >> \"#{dst}\""
        status == 0
      end
      
      def append_compressed_js_to_file src, dst
        status, stdout, stderr = systemu "#{@config[:exec][:uglifyjs]} \"#{src}\" --extras --unsafe >> \"#{dst}\""
        status == 0
      end
      
    end
    
  end
  
end