require 'spec_helper'
describe 'freepbx' do
  context 'when on Debian' do
    let (:facts) { {
      :osfamily        => 'Debian',
      :operatingsystem => 'Debian',
      :lsbdistcodename => 'wheezy',
    } }

    context 'when no parameters are specified' do
      let (:params) { { } }
      it 'should fail' do
        expect { should compile }.to raise_error(Puppet::Error, /Must pass/)
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
