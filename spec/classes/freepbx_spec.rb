require 'spec_helper'

describe 'freepbx' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/foo',
        })
      end

      context 'when no parameters are specified' do
        let (:params) { { } }
        it 'should fail' do
          expect { should compile }.to raise_error(/asterisk_db_pass/)
        end
      end

      context 'when specifying password' do
        let (:params) { {
          :asterisk_db_pass => 'foobarbaz',
        } }

        it { should compile.with_all_deps }
      end
    end
  end
end
