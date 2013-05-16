require 'spec_helper'
class FakeController < ActionController::Base
end

describe Authoryze do
  subject {FakeController.new}

  describe '#can' do
    it 'returns true if user has permission' do
      role = Role.create :name => 'boss', :permissions => {'manage_peons?' => true}
      user = create :user, :roles => [role]
      subject.stub(:current_user => user)
      subject.can.manage_peons?.should be_true
    end

    it 'raises AccessDenied error if user does not have permission' do
      role = Role.create :name => 'boss', :permissions => {'manage_peons?' => true}
      user = create :user, :roles => [role]
      subject.stub(:current_user => user)
      subject.can.manage_big_boss?.should be_false
    end

    it 'returns true for permissions from any of the roles' do
      role = Role.create :name => 'boss', :permissions => {'manage_peons?' => true}
      role2 = Role.create :name => 'boss2', :permissions => {'manage_underlings?' => true}
      user = create :user, :roles => [role, role2]
      subject.stub(:current_user => user)
      subject.can.manage_peons?.should be_true
      subject.can.manage_underlings?.should be_true
    end
  end
end

