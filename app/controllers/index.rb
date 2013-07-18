get '/' do
  if current_user
    redirect to "/profile/#{current_user.id}"
  else
    erb :index
  end
end

get '/login' do
  session[:user_id] = nil
  erb :login
end

post '/login' do
  @user = User.authenticate(params[:user][:username], params[:user][:password])
  if @user
    session[:user_id] = @user.id
    redirect "/profile/#{@user.id}"
  else
    @fail = "Username and/or password does not exist."
    erb :login
  end

end

get '/create_user' do
  erb :create_user
end

post '/create_user' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect "/profile/#{@user.id}"
  else
    @errors = @user.errors
    erb :create_user
  end
end

get '/profile/:user_id' do
  if User.find_by_id(params[:user_id]) == current_user
    @user = current_user
    @links = Url.find_all_by_user_id(@user.id)
    erb :profile
  else 
    redirect '/lol_nope'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/lol_nope' do
  session[:user_id] = nil
  erb :lol_nope
end