require 'spec_helper'

describe Jrxades do

  # KeyData information
  let(:key_store_path){ File.join(File.dirname(__FILE__), '../../fixtures/certificate.p12') }
  let(:key_store_path_without_pass){ File.join(File.dirname(__FILE__), '../../fixtures/certificate_without_password.p12') }
  let(:invalid_key_store_path){ File.join(File.dirname(__FILE__), '../../fixtures/text.p12') }
  let(:pass_phrase_for_key_store){ 'pass' }
  let(:pass_phrase_for_key){ 'pass' }

  # Input file to sign and output file
  let(:input_file_path){ File.join(File.dirname(__FILE__), '../../fixtures/unsignedFile.xml') }
  let(:output_file_path){ File.join(File.dirname(__FILE__), '../../../tmp/outputFile.xml') }  


  before do
    @xml_sig = Jrxades::XmlSig.new(input_file_path, output_file_path, key_store_path, pass_phrase_for_key_store, pass_phrase_for_key)
  end

  after do
    File.delete(output_file_path) if File.exist?(output_file_path)
  end

  describe '.initializer' do

    it 'should create a new XmlSig instance with full parameters' do
      Jrxades::XmlSig.new key_store_path, pass_phrase_for_key_store, pass_phrase_for_key
    end

    it 'assig key_store_path' do
      @xml_sig.key_store_path.should == key_store_path
    end

    it 'assig pass_phrase_for_key_store' do
      @xml_sig.pass_phrase_for_key_store.should == pass_phrase_for_key_store
    end

    it 'assig pass_phrase_for_key' do
      @xml_sig.pass_phrase_for_key.should == pass_phrase_for_key
    end

    it 'assig output_path' do
      @xml_sig.output_path.should == File.dirname(output_file_path)
    end

    it 'assig out_file_name' do
      @xml_sig.out_file_name.should == File.basename(output_file_path)
    end

    it 'assig input_file_path' do
      @xml_sig.input_file_path.should == input_file_path
    end

    context 'without mandatory parameters' do

      before do
        @xml_sig = Jrxades::XmlSig.new(input_file_path, output_file_path, key_store_path)
      end

      it 'assig pass_phrase_for_key_store' do
        @xml_sig.pass_phrase_for_key_store.should == ''
      end

      it 'assig pass_phrase_for_key' do
        @xml_sig.pass_phrase_for_key.should == ''
      end

    end

  end

  describe '#sign' do
    before do
      @xml_sig.sign
    end

    it 'create a output file' do
      File.exist?(output_file_path).should be_true
    end

    it 'create the sign into the output file' do
      File.read(output_file_path).should_not be_empty
    end
  end

  describe '#key_data_valid?' do

    it 'is valid' do
      @xml_sig.key_data_valid?.should be_true
    end

    it 'throw an exception if the p12 key is invalid' do
      expect { 
        xml_sig = Jrxades::XmlSig.new(input_file_path, output_file_path, invalid_key_store_path)
        xml_sig.key_data_valid?
      }.to raise_error Jrxades::Exceptions::XmlSigException
    end

    it 'throw an exception if the p12 key has invalid passwords' do
      expect { 
        xml_sig = Jrxades::XmlSig.new(input_file_path, output_file_path, key_store_path, 'foo', 'foo')
        xml_sig.key_data_valid?
      }.to raise_error Jrxades::Exceptions::XmlSigException
    end

    it 'throw an exception if the p12 key needs passwords' do
      expect { 
        xml_sig = Jrxades::XmlSig.new(input_file_path, output_file_path, key_store_path)
        xml_sig.key_data_valid?
      }.to raise_error Jrxades::Exceptions::XmlSigException
    end

  end

end