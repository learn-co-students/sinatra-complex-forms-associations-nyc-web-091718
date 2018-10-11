class PetsController < ApplicationController

#get all pet instances
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

#generates a new form
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

#user fills out form to create pets with poss. owners
  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner_id = Owner.create(name: params["owner"]["name"]).id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

#generates pet form for user to edit
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

#find pet by ID and display it on the show page rather than home page
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

#update an existing pet
  patch '/pets/:id' do
    #find pet that matches ID first
    @pet = Pet.find(params[:id])
 ## bug fix required to remove ALL previous pets from owner.
    if !params[:pet].keys.include?("owner_id")
    params[:pet]["owner_id"] = []
    end
    ##bug fix ends here
    @pet.update(params["pet"])

    if !params["owner"]["name"].empty?
      @pet.owner_id = Owner.create(name: params["owner"]["name"]).id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
