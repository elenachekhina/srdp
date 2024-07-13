class RatesController < ApplicationController
  before_action :set_rateable, only: %i[new create]
  before_action :set_rate, only: %i[edit update]

  def new
    @rate = @rateable.rates.new

    authorize! @rate

    render :new
  end

  def create
    @rate = @rateable.rates.build(rate_params)

    authorize! @rate

    if @rate.save
      render :create
    else
      render :new
    end
  end

  def edit
    authorize! @rate

    render :edit
  end

  def update
    authorize! @rate

    if @rate.update(rate_params)
      redirect_to @rate.rateable
    else
      render :edit
    end
  end

  private

  def set_rate
    @rate = Rate.find(params[:id])
  end

  def set_rateable
    klass = [Organization].detect { |c| params["#{c.name.underscore}_id"] }
    @rateable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def rate_params
    params.require(:rate).permit(:value, :comment).merge(rater: current_user)
  end
end
