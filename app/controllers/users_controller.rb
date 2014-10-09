class UsersController < ApplicationController
    before_action :set_user, only: [:show]
    skip_before_action :verify_authenticity_token
  
    def home
        
    end
  
    def signup
        user = User.new
        user.username = params[:username]
        user.password = params[:password]
        
        if user.valid?
            user.count = 1
            user.save
            render json: {user_name: user.username, login_count: user.count}        
        else
            error = user.errors.values.flatten.first
            render json: {error_code: error.to_i}
        end
    end
    
    def login
        username = params[:username]
        password = params[:password]
        user = User.find_by(username: username, password:password)
        if user
            user.update(count: user.count+1)
            render json: {user_name: user.username, login_count: user.count}        
        else
            render json: {error_code: -4}
        end
    end
    
    def cleardata
        User.destroy_all
        render :nothing => true
    end

    # GET /users/new
    def new
        @user = User.new
    end

    # POST /users
    # POST /users.json
    def create
        @user = User.new(user_params)
        action = params[:commit]
        if action == "Add User"
            respond_to do |format|
                if @user.valid?
                    @user.count = 1
                    @user.save
                    format.html { redirect_to @user, notice: 'User was successfully created.' }
                else
                    format.html { render :new }
                end
            end
        elsif action == "Login"
            username = params[:user][:username]
            password = params[:user][:password]
            user = User.find_by(username: username, password:password)
            respond_to do |format|
                if user != nil
                    user.update(count: user.count+1)
                    format.html { redirect_to user, notice: 'User was successfully logged in.' }
                else
                    @user.errors.add(:error_code, "-3")                    
                    format.html { render :new }
                end
            end
        end
    end

    # GET /users/1
    # GET /users/1.json
    def show
    end

    def index
        @users = User.all
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:username, :password, :count)
    end
end
