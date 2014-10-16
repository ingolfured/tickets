class TicketPolicy < ApplicationPolicy
  attr_reader :user, :ticket

  def initialize(user, ticket)
    @user = user
    @ticket = ticket
  end

  def update?
    not user.nil?
  end

  def show?
    not user.nil?
  end

  def destroy?
    not user.nil?
  end

  def index?
    not user.nil?
  end

  def list_new?
    not user.nil?
  end

  def list_open?
    not user.nil?
  end


  def list_onhold?
    not user.nil?
  end

  def list_closed?
    not user.nil?
  end

end
