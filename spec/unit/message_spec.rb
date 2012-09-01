require 'spec_helper'

describe Message do
  before do
    @message = create(:message)
  end

  after do
    @message.destroy
  end

  # assocations
  it { should have_and_belong_to_many(:labels) }
  it { should belong_to(:mailbox) }
  it { should have_one(:account).through(:mailbox) }
  it { should have_one(:user).through(:account) }
  it { should have_many(:attachments) }
  it { should have_many(:participants) }
    it { should have_many(:toers) }
    it { should have_many(:fromers) }
    it { should have_many(:senders) }
    it { should have_many(:ccers) }
    it { should have_many(:bccers) }
    it { should have_many(:reply_toers) }

  # validations
  it { should validate_presence_of(:mailbox) }

  # methods
  describe 'unread?' do
    it 'should return true if the message was not yet read' do
      @message.read = true
      @message.unread?.should == false
    end

    it 'should return false if the was was already read' do
      @message.read = false
      @message.unread?.should == true
    end
  end

  describe 'mark_as_read!' do
    it 'should mark a message as read' do
      @message.read = false

      expect {
        @message.mark_as_read!
      }.to change(@message, :read).to(true)
    end
  end

  describe 'mark_as_unread!' do
    it 'should mark a message as unread' do
      @message.read = true

      expect {
        @message.mark_as_unread!
      }.to change(@message, :read).to(false)
    end
  end

  describe 'flag!' do
    it 'should flag a message' do
      @message.flagged = false
      expect {
        @message.flag!
      }.to change(@message, :flagged).to(true)
    end
  end

  describe 'unflag!' do
    it 'should unflag a message' do
      @message.flagged = true

      expect {
        @message.unflag!
      }.to change(@message, :flagged).to(false)
    end
  end

  describe 'move_to_trash!' do
    it 'should delete the message' do
      expect {
        @message.mark_as_read!
      }.to change(Message, :count).by(1)
    end
  end

  describe 'uid_store' do
    it 'should create a new Envelope::IMAP instance' do
    end
  end

  describe 'uid_copy' do
    it 'should create a new Envelope::IMAP instance' do
    end
  end
end