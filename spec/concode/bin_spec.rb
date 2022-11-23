require 'spec_helper'

describe 'bin/concode' do
  subject { 'bin/concode' }

  describe 'without arguments' do
    it 'shows banner' do
      expect(`#{subject}`).to match_approval 'bin/banner'
    end
  end

  describe 'with --help' do
    it 'shows usage' do
      expect(`#{subject} --help`).to match_approval 'bin/usage'
    end
  end

  describe 'with --version' do
    it 'shows version' do
      expect(`#{subject} --version`.strip).to eq Concode::VERSION
    end
  end

  describe 'with string' do
    it 'prints a 2 words code' do
      expect(`#{subject} danny`.strip).to eq 'dreary-self'
    end

    context 'with --words 3' do
      it 'prints a 3 word code' do
        expect(`#{subject} danny --words 3`.strip).to eq 'womanly-dreary-self'
      end
    end

    context 'with --chars 3' do
      it 'prints a code with 2 words 3 letters each' do
        expect(`#{subject} hello --chars 3`.strip).to eq 'red-bar'
      end
    end

    context 'with --glue _' do
      it 'uses the argument to join the words' do
        expect(`#{subject} potato --glue _`.strip).to eq 'friendly_private'
      end
    end

    context 'with --caps' do
      it 'capitalizes words in the output' do
        expect(`#{subject} tomato --caps`.strip).to eq 'Dapper-Value'
      end
    end
  end

  describe 'with --random' do
    it 'prints a 2 words code' do
      expect(`#{subject} --random`.strip).to match(/^\w{3,13}-\w{3,13}$/)
    end

    it 'obeys other flags' do
      expect(`#{subject} --random -c3 -w4`.strip).to match(/^\w{1,3}-\w{1,3}-\w{1,3}-\w{1,3}$/)
    end
  end

  describe 'with --count' do
    it 'prints combination count' do
      expect(`#{subject} --count`.strip).to eq '1701900'
    end

    it 'obeys other flags' do
      expect(`#{subject} --count -c3 -w4`.strip).to eq '1589760'
    end
  end
end
