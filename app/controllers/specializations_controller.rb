# Controller for handling specializations
class SpecializationsController < ApplicationController
  # before_action: authorize request, except for the index action
  before_action :authorize_request, except: :index
  before_action :set_specialization, only: %i[show update destroy]

  # GET /specializations
  # @param specializations [String]
  def index
    @specializations = Specialization.all
    render json: @specializations
  end

  # GET /specializations/1
  def show
    render json: @specialization
  end

    end
  end

end
