require 'spec_helper'
describe 'fusiondirectory' do

  context 'with defaults for all parameters' do
    it { should contain_class('fusiondirectory') }
  end
end
