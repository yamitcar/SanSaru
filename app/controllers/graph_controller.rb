class GraphController < ApplicationController

  before_action :require_login

  def index
  end

  def data
    respond_to do |format|
      format.json {
        render :json => {treeOne:
                             {
                                 name: "Camilo Velasquez",
                                 parent: "null",
                                 children: [
                                     {
                                         name: "Alan Brito",
                                         parent: "Camilo Velasquez"
                                     },
                                     {
                                         name: "Juan Nuez",
                                         parent: "Camilo Velasquez",
                                         children: [
                                             {
                                                 name: "Alan Brito",
                                                 parent: "Juan Nuez"
                                             },
                                             {
                                                 name: "Juan Nuez 2",
                                                 parent: "Juan Nuez"
                                             }
                                         ]
                                     }
                                 ]
                             }
                        }
      }
    end
  end

end