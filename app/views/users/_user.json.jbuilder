json.(user, :id, :email, :handle, :birthday)
json.token user.generate_jwt