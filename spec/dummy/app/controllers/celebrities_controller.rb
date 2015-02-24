class CelebritiesController < ApplicationController

  def index
    render nothing: true
  end

  def show
    celebrity = Celebrity.find(celebrity_id)
    render nothing: true
  end

  def create
    Celebrity.create(celebrity_params)
    render nothing: true
  end

  def multiply
    2.times{ Celebrity.create(celebrity_params) }
    render nothing: true
  end

  def celebrity_id
    params[:id]
  end

  def celebrity_params
    params.require(:celebrity).permit(:first_name, :last_name, :gender, :birth_date)
  end

end
