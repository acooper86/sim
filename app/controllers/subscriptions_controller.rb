class SubscriptionsController < ApplicationController
  before_filter :authenticate, :only => [:index,:show, :new, :create, :edit, :update]
  before_filter :correct_user, :only => [:new, :create, :edit,:update]
  
  layout "logged"
  
 
  
  
  def new
    @title = "New subscription"
    @user = User.find(params[:user_id])
    @subscription = @user.subscription.new
  end

  def create
    @user = User.find(params[:user_id])
    @subscription = @user.subscription.new(params[:subscription])
    
    ###Create the gateway to connect to paypal
    gateway ||= ActiveMerchant::Billing::PaypalRecurringGateway.new(
      :login => 'fluke.a_api1.gmail.com',
      :password => 'MT5PWUNPULG2MQR3',
      :signature => 'AdUvMCgrvhVK-xDQpFEUKOppiiYcAaH6.EGnywN5fG.1HzKOVHcUTF9r')
    
    credit_card = ActiveMerchant::Billing::CreditCard.new(params[:credit_card])
    
    response = gateway.create_profile(nil, :credit_card => credit_card,
      :description => 'Massage Website Guru Normal Level',
      :start_date => @user.created_at + 1.months,
      :period => 'Month',
      :frequency => 1,
      :amount => 2499,
      :auto_bill_outstanding => true)
 
    if response.success?
      if @subscription.save
        flash[:success] = "Your subscription was created successfully."
      else
        @title = "Error Creating Subscription."
        render 'new'
      end
    else
      @title = "Card not authorized"
      flash[:notice] = "There was an error processing your subscription"
      render 'new'
    end
  end

  def edit
  end

private
  	def authenticate
  		deny_access unless signed_in?
  	end
  	
  	def correct_user
  		@user = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@user)
  	end
end
