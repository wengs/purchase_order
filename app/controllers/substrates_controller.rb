class SubstratesController < ApplicationController
  before_filter :verify_is_admin
  before_action :set_substrate, only: [:show, :edit, :update, :destroy]

  # GET /substrates
  # GET /substrates.json
  def index
    @q = Substrate.ransack(params[:q])
    @substrates = @q.result.page(params[:page]).per(25)
    #@substrates = Substrate.all
  end

  # GET /substrates/1
  # GET /substrates/1.json
  def show
  end

  # GET /substrates/new
  def new
    @substrate = Substrate.new
  end

  # GET /substrates/1/edit
  def edit
  end

  # POST /substrates
  # POST /substrates.json
  def create
    @substrate = Substrate.new(substrate_params)

    respond_to do |format|
      if @substrate.save
        format.html {
          flash[:success] = 'Substrate was successfully created.'
          redirect_to @substrate
        }
        format.json { render :show, status: :created, location: @substrate }
      else
        format.html { render :new }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /substrates/1
  # PATCH/PUT /substrates/1.json
  def update
    respond_to do |format|
      if @substrate.update(substrate_params)
        format.html {
          flash[:success] = 'Substrate was successfully updated.'
          redirect_to @substrate
        }
        format.json { render :show, status: :ok, location: @substrate }
      else
        format.html { render :edit }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /substrates/1
  # DELETE /substrates/1.json
  def destroy
    @substrate.destroy
    respond_to do |format|
      format.html {
        if @substrate.errors.present?
          flash[:error] = @substrate.errors.full_messages.to_sentence
        else
          flash[:success] = 'Substrate was successfully destroyed.'
        end
        redirect_to substrates_path
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_substrate
      @substrate = Substrate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def substrate_params
      params.require(:substrate).permit(:name, :client_cost, :our_cost)
    end
end
