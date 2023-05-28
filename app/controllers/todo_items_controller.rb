class TodoItemsController < ApplicationController

  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]
  
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    item_name = @todo_item[:content]
    if @todo_item.destroy
      flash[:success] = "Item '#{item_name}' was deleted."
    else
      flash[:error] = "Item '#{item_name}' item could not be deleted."
    end
    count_item = TodoItem.where(todo_list_id: params[:todo_list_id]).count()
    if count_item == 0 
      list_name = @todo_list[:title]
      @todo_list.destroy
      flash[:success] = "List '#{list_name}' was deleted."
      redirect_to root_url 
    else
      redirect_to @todo_list
    end
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo item completed"
  end

  def show
    redirect_to @todo_list
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end
  
end
