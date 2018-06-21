require 'spec_helper'

describe 'bin/concode' do
  subject { 'bin/concode' }

  describe 'without arguments' do
    it "shows banner" do
      expect(`#{subject}`).to match_fixture 'bin/banner'
    end
  end

  describe '--help' do
    it "shows usage" do
      expect(`#{subject} --help`).to match_fixture 'bin/usage'
    end
  end

  describe '--version' do
    it "shows version" do
      expect(`#{subject} --version`.strip).to eq VERSION
    end
  end

  describe 'with string' do
    it "prints a 2 words code" do
      expect(`#{subject} danny`.strip).to eq "dreary-self"
    end

    context "--words 3" do
      it "prints a 3 word code" do
        expect(`#{subject} danny --words 3`.strip).to eq "womanly-dreary-self"
      end
    end

    context "--chars 3" do
      it "prints a code with 2 words 3 letters each" do
        expect(`#{subject} hello --chars 3`.strip).to eq "red-bar"
      end
    end

    context "--glue _" do
      it "uses the argument to join the words" do
        expect(`#{subject} potato --glue _`.strip).to eq "friendly_private"
      end
    end

    context "--caps" do
      it "capitalizes words in the output" do
        expect(`#{subject} tomato --caps`.strip).to eq "Dapper-Value"
      end
    end
  end

  describe '--random' do
    it "prints a 2 words code" do
      expect(`#{subject} --random`.strip).to match(/^\w{3,13}\-\w{3,13}$/)
    end

    it "obeys other flags" do
      expect(`#{subject} --random -c3 -w4`.strip).to match(/^\w{1,3}\-\w{1,3}\-\w{1,3}\-\w{1,3}$/)
    end
  end

  describe '--count' do
    it "prints combination count" do
      expect(`#{subject} --count`.strip).to eq "1701900"
    end

    it "obeys other flags" do
      expect(`#{subject} --count -c3 -w4`.strip).to eq "1589760"
    end
  end

end
