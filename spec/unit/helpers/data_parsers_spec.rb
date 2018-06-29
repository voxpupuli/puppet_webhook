require 'spec_helper'
require 'logger'

describe DataParsers do
  subject do
    Class.new do
      include DataParsers
    end
  end

  describe '#sanitize_input' do
    it 'should sanitize and escape characters in a module or branch name' do
      stub_const('LOGGER', Logger.new(nil))
      expect(subject.new.sanitize_input('$mybranch')).to eq('\\$mybranch')
    end

    it 'should not sanitize the module or branch name' do
      stub_const('LOGGER', Logger.new(nil))
      expect(subject.new.sanitize_input('module_name')).to eq('module_name')
    end
  end

  describe '#normalize' do
    it 'should take in a string with uppercase and not change it' do
      t = 'AllowUpperCaseStrings'
      upper = true
      expect(subject.new.normalize(upper, t)).to eq(t)
    end

    it 'should take in a string with uppercase and normalize it' do
      t = 'AllowUpperCaseStrings'
      upper = false
      expect(subject.new.normalize(upper, t)).to eq('allowuppercasestrings')
    end
  end
end
