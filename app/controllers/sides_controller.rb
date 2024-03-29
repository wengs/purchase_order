class SidesController < ApplicationController
  before_filter :verify_is_admin
  before_action :set_side, only: [:show, :edit, :update, :destroy]

  # GET /sides
  # GET /sides.json
  def index
    @sides = Side.all
  end

  # GET /sides/1
  # GET /sides/1.json
  def show
  end

  # GET /sides/new
  def new
    @side = Side.new
  end

  # GET /sides/1/edit
  def edit
  end

  # POST /sides
  # POST /sides.json
  def create
    @side = Side.new(side_params)

    respond_to do |format|
      if @side.save
        format.html {
          flash[:success] = 'Side was successfully created.'
          redirect_to @side
        }
        format.json { render :show, status: :created, location: @side }
      else
        format.html { render :new }
        format.json { render json: @side.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sides/1
  # PATCH/PUT /sides/1.json
  def update
    respond_to do |format|
      if @side.update(side_params)
        format.html {
          flash[:success] = 'Side was successfully updated.'
          redirect_to @side
        }
        format.json { render :show, status: :ok, location: @side }
      else
        format.html { render :edit }
        format.json { render json: @side.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sides/1
  # DELETE /sides/1.json
  def destroy
    @side.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'Side was successfully destroyed.'
        redirect_to sides_url
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_side
      @side = Side.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def side_params
      params.require(:side).permit(:name)
    end
end
