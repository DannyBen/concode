require 'spec_helper'

describe 'Codenamize Compatibility', :codenamize do
  word = 'hello'
  opts = {}
  pyopts = ''

  let(:ours)   { Generator.new(**opts).generate word }
  let(:theirs) { `codenamize #{pyopts} '#{word}'`.strip }

  context 'without arguments' do
    it 'generates the same strings' do
      expect(ours).to match theirs
    end
  end

  context 'with --words' do
    it 'generates the same strings' do
      (3..6).each do |words|
        opts = { words: words }
        pyopts = "-p #{words - 1}"
        expect(ours).to match theirs
      end
    end
  end

  context 'with --chars' do
    it 'generates the same strings' do
      [3, 4, 5, 6, 7, 8, 9, 0].each do |chars|
        opts = { chars: chars }
        pyopts = "-m #{chars}"
        expect(ours).to match theirs
      end
    end
  end

  context 'when kicking ass and chewing bubble gum' do
    it 'generates the same strings' do
      word = 'its time to kick ass and chew bubble gum'
      expect(ours).to match theirs
      expect(ours).to eq 'evasive-task'
    end
  end
end
