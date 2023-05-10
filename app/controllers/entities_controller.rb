class EntitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_entity, only: %i[show edit update destroy]

  def index
    @group = Group.find(params[:group_id])
    @header = 'Transactions'
    @entities = @group.entities.where(author: current_user).order(created_at: :desc)
  end

  def new
    @header = 'New Transaction'
    @entity = @group.entities.build
    @groups = current_user.groups
  end

  def create
    @entity = @group.entities.build(entity_params)

    respond_to do |format|
      if @entity.save
        format.html do
          redirect_to user_group_entities_path(current_user, @group), notice: 'Transacction was successfully created!'
        end
        format.json { render :show, status: :created, location: @entity }
      else
        format.html { render :new }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    if @entity.update(entity_params)
      redirect_to user_group_entities_path(@entity.group), notice: 'Transacction was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @entity.destroy
    redirect_to user_group_entities_path(@entity.group), notice: 'Transacction was successfully destroyed!'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount, :author_id)
  end
end
