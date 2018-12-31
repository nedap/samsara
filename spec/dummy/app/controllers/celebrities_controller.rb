class CelebritiesController < ApplicationController

  def index
    head :ok
  end

  def show
    celebrity = Celebrity.find(celebrity_id)
    head :ok
  end

  def create
    Celebrity.create(celebrity_params)
    head :ok
  end

  def multiply
    2.times{ Celebrity.create(celebrity_params) }
    head :ok
  end

  def celebrity_id
    params[:id]
  end

  def celebrity_params
    params.require(:celebrity).permit(:first_name, :last_name, :gender, :birth_date)
  end

end
