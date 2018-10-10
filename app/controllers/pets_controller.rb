class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet_name"])
    @owner = Owner.find(params["pet"]["owner_id"].first) if !params["pet"].nil?
    @owner = Owner.create(name: params["owner_name"]) if !params["owner_name"].empty?
    @pet.owner = @owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params["id"])
    @pet.update(name: params["pet_name"])
    @pet.owner = Owner.find(params["pet"]["owner_id"].first) if !params["pet"].nil?
    @pet.owner = Owner.find_or_create_by(name: params["owner"]["name"]) if !params["owner"]["name"].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
