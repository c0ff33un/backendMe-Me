class TemplatesController < ApplicationController
    def index
        template = Template.all
        render json: template, status: :ok
    end

    def show
        template = Template.find(params[:id])
        render json: template, status: :ok
    end

    def create
        template = Template.create(template_params)
        if template.valid?
            render json: template, status: :created
        else
            render json: template.errors, status: :unprocessable_entity
        end
    end

    def update
        template = Template.find(params[:id])
        template.image.purge if template.image.attached?
        if template.update(template_params)
            render json: template, status: :ok
        else
            render json: template.errors, status: :unprocessable_entity
        end
    end

    def destroy
        template = Template.find(params[:id])
        template.destroy
        if template.destroyed?
            render json: template, status: :ok
        else
            render json: template.errors, status: :unprocessable_entity
        end
    end
    private
    def template_params
        params.require(:template).permit(:description, :image)
    end
end
