class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

#generate form for user
  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

#user fills out form to post data to db and then redirect to the page
post '/owners' do
  @owner = Owner.create(params[:owner])
  if !params["pet"]["name"].empty?
    @owner.pets << Pet.create(name: params["pet"]["name"])
  end
  redirect "owners/#{@owner.id}"
end

#generates owner form for user to edit
  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

#see an id that belongs to a particular owner
  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

#updates information that is posted to db and then back to show page
  patch '/owners/:id' do
    #find owner that matches ID first
    @owner = Owner.find(params[:id])
 ## bug fix required to remove ALL previous pets from owner.
    if !params[:owner].keys.include?("pet_ids")
    params[:owner]["pet_ids"] = []
    end
    ##bug fix ends here

    @owner.update(params["owner"])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end

end
