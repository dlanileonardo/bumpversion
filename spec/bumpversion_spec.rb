require 'spec_helper'

describe Bumpversion::Bumpversion do
  it 'has a version number' do
    expect(Bumpversion::VERSION).not_to be nil
  end

  context 'no params' do
    it 'raise error' do
      expect { Bumpversion::Bumpversion.new }.to raise_error SystemExit
    end
  end

  describe 'wihout file' do
    context 'with current and new version' do
      let(:arguments) { ['--new-version=1.1.0', '--current-version=1.0.0'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '1.0.0' }
      it { is_expected.to include new_version: '1.1.0' }
    end
    context 'minor' do
      let(:arguments) { ['--current-version=1.0.0'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '1.0.0' }
      it { is_expected.to include new_version: '1.1.0' }
    end
    context 'major' do
      let(:arguments) { ['--current-version=1.0.0', '--part=major'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '1.0.0' }
      it { is_expected.to include new_version: '2.0.0' }
    end
    context 'patch' do
      let(:arguments) { ['--current-version=1.0.0', '--part=patch'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '1.0.0' }
      it { is_expected.to include new_version: '1.0.1' }
    end
  end
end
