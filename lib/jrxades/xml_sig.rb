require 'java'
require File.join(File.dirname(__FILE__), '../../java/sri.jar')

java_import 'sri.XAdESBESSignature'

module Jrxades

  class XmlSig

    attr_accessor :key_store_path, :pass_phrase_for_key_store, :pass_phrase_for_key, :output_path, :out_file_name, :input_file_path

    def initialize(input_file_path, output_file_path, key_store_path, pass_phrase_for_key_store=nil, pass_phrase_for_key=nil)
      self.key_store_path = key_store_path
      self.pass_phrase_for_key_store = pass_phrase_for_key_store || ''
      self.pass_phrase_for_key = pass_phrase_for_key || ''
      self.output_path = File.dirname(output_file_path)
      self.out_file_name = File.basename(output_file_path)
      self.input_file_path = input_file_path
    end

    def sign
      XAdESBESSignature.firmar(input_file_path, key_store_path, pass_phrase_for_key_store, output_path, out_file_name)
    end

    def key_data_valid?
      begin
        sign_test
      rescue Exception => e
        raise Jrxades::Exceptions::XmlSigException.new(e)
      end
    end

    private

    def sign_test
      input_test_file = File.join(File.dirname(__FILE__), '../../spec/fixtures/unsignedFile.xml')      
      output_test_file = File.join(File.dirname(__FILE__), '../../spec/fixtures/testSignedFile.xml')

      input_file_path = input_test_file
      output_path = File.dirname(output_test_file)
      out_file_name = File.basename(output_test_file)

      sign

      File.open(output_test_file, 'w') { |f| f.print("") }
      File.read(output_test_file) == ""
    end

  end

end
