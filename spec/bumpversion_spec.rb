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
      let(:arguments) { ['--current-version=1.0.1'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '1.0.1' }
      it { is_expected.to include new_version: '1.1.0' }
    end
    context 'major' do
      let(:arguments) { ['--current-version=1.0.1', '--part=major'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '1.0.1' }
      it { is_expected.to include new_version: '2.0.0' }
    end
    context 'patch' do
      let(:arguments) { ['--current-version=1.1.1', '--part=patch'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '1.1.1' }
      it { is_expected.to include new_version: '1.1.2' }
    end
  end

  describe 'with file' do
    before do
      File.write('./spec/files/bumpversion.cfg', "[bumpversion]\ncurrent-version=2.1.1\n")
      File.write('./spec/files/VERSION', "version=2.1.1\n")
    end
    after(:all) do
      File.write('./spec/files/bumpversion.cfg', '')
      File.write('./spec/files/VERSION', '')
    end
    context 'patch' do
      let(:arguments) { ['--config-file=./spec/files/bumpversion.cfg', '--file=./spec/files/VERSION', '--part=patch'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      let!(:bump_run) { bump_instance.run }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '2.1.1' }
      it { is_expected.to include new_version: '2.1.2' }
      it "do bump file" do
        expect(File.read('./spec/files/bumpversion.cfg')).to include("current-version=2.1.2")
        expect(File.read('./spec/files/VERSION')).to include("version=2.1.2")
      end
    end
    context 'minor' do
      let(:arguments) { ['--config-file=./spec/files/bumpversion.cfg', '--file=./spec/files/VERSION', '--part=minor'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      let!(:bump_run) { bump_instance.run }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '2.1.1' }
      it { is_expected.to include new_version: '2.2.0' }
      it "do bump file" do
        expect(File.read('./spec/files/bumpversion.cfg')).to include("current-version=2.2.0")
        expect(File.read('./spec/files/VERSION')).to include("version=2.2.0")
      end
    end
    context 'major' do
      let(:arguments) { ['--config-file=./spec/files/bumpversion.cfg', '--file=./spec/files/VERSION', '--part=major'] }
      let(:bump_instance) { Bumpversion::Bumpversion.new arguments }
      let!(:bump_run) { bump_instance.run }
      subject { bump_instance.instance_variable_get(:@options) }

      it { expect(bump_instance).to be_a Bumpversion::Bumpversion }
      it { is_expected.to be_a Hash }
      it { is_expected.to include :help  }
      it { is_expected.to include :part  }
      it { is_expected.to include :file  }
      it { is_expected.to include current_version: '2.1.1' }
      it { is_expected.to include new_version: '3.0.0' }
      it "do bump file" do
        expect(File.read('./spec/files/bumpversion.cfg')).to include("current-version=3.0.0")
        expect(File.read('./spec/files/VERSION')).to include("version=3.0.0")
      end
    end
  end
end
