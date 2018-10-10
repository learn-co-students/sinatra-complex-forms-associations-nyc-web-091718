class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do

    erb :'/pets/new'
  end

  post '/pets' do

     if !params["owner_name"].empty?
       @pet = Pet.create(params[:pet])
       owner = Owner.create(name: params["owner_name"])
       owner.pets << @pet
     end

     if params[:pet][:owner_ids]!=nil
       @pet = Pet.create({"name" =>params[:pet][:name]})
       params[:pet][:owner_ids].each do |o|
         owner = Owner.find(o.to_i)
         owner.pets << @pet
       end
     end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(@params[:id])
    @pet.update(params[:pet])
    if params[:owner_id]!=nil
      own = Owner.find(params[:owner_id].to_i)
      own.pets << @pet
    end
    #######
    if params[:owner][:name] != ""
      owner = Owner.create(params[:owner])
      owner.pets << @pet
    end

    redirect to "pets/#{@pet.id}"
  end
end
