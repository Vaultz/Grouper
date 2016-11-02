User.destroy_all
Workshop.destroy_all
Project.destroy_all
Work.destroy_all


#Hash with fake users
f_u = Array.new
#the loop which create each user
f_u[0] = {:firstname => 'Patrick', :lastname => 'Chirac', :email => 'p.c@gmail.com', :year =>2016, :password => 'pastis', :status => 0, :gender => 'm'}
f_u[1] = {:firstname => 'Régis-robert', :lastname => 'Régis-robert', :email => 'dagobert@gmail.com', :year =>2016, :password => 'hugodelire', :status => 0, :gender => 'm'}
f_u[2] = {:firstname => 'Nicolas', :lastname => 'Sarkozy', :email => 'talonnette@gmail.com', :year =>2016, :password => '#notrialforme', :status => 1, :gender => 'm'}
f_u[3] = {:firstname => 'Obiwan', :lastname => 'Kenoby', :email => 'foreveralone@gmail.com', :year =>2016, :password => 'notthepasswordyouarelookingfor', :status => 0, :gender => 'm'}
f_u[4] = {:firstname => 'Bob', :lastname => 'l\'éponge', :email => 'jesuispasunemmental@gmail.com', :year =>2016, :password => 'garyforever', :status => 1, :gender => 'm'}
f_u[5] = {:firstname => 'Speedy', :lastname => 'Gonzalez', :email => 'SoyMexicanos@gmail.com', :year =>2016, :password => 'ouiunpeuraciste', :status => 0, :gender => 'm'}
f_u[6] = {:firstname => 'Fanklin', :lastname => 'la tortue', :email => 'saitlasserseslacets@gmail.com', :year =>2016, :password => 'napasdechaussures', :status => 1, :gender => 'm'}
f_u[7] = {:firstname => 'Mr', :lastname => 'Robot', :email => 'h-a-t@gmail.com', :year =>2016, :password => 'hacker/justicier', :status => 0, :gender => 'm'}
f_u[8] = {:firstname => 'Robin', :lastname => 'Wood', :email => 'MorningWood@gmail.com', :year =>2016, :password => 'envraijesuisjustesdf', :status => 0, :gender => 'm'}
f_u.each do |user|
  new_user = User.new(:firstname => user[:firstname], :lastname => user[:lastname], :email => user[:email], :year => user[:year], :password => user[:password], :password_confirmation => user[:password], :status => user[:status], :gender => user[:gender]  )
  new_user.save!
end
#Fake worshop Hash

f_w = Array.new
f_w[0] = {:name => 'SQL', :description => 'Création d\'un schéma de base de données, associé à un CRUD et des exemples de requêtes SQL ', :teacher => 'Hitcham', :begins => '16-09-2016', :ends => '20-01-2017', :teamnumber =>'4', :teamgeneration => 0, :created_at => '16-09-2016', :projectleaders => 0, :year => '2016'}
f_w[1] = {:name => 'SQL', :description => 'Création d\'un schéma de base de données, associé à un CRUD et des exemples de requêtes SQL ', :teacher => 'Hitcham', :begins => '16-09-2015', :ends => '20-01-2016', :teamnumber =>'4', :teamgeneration => 0, :created_at => '16-09-2015', :projectleaders => 0, :year => '2015'}
f_w[2] = {:name => 'Devis', :description => 'Éditer un devis pour un projet fictif avec M Ricard qui s\'amuse à jouer M.Fortineau', :teacher => 'Laurent', :begins => '20-09-2016', :ends => '16-10-2016', :teamnumber =>'3', :teamgeneration => 0, :created_at => '20-09-2016', :projectleaders => 1, :updated_at =>'20-09-2016', :year => '2016'}
f_w[3] = {:name => 'Devis', :description => 'Éditer un devis pour un projet fictif avec M Ricard qui s\'amuse à jouer M.Fortineau', :teacher => 'Laurent', :begins => '20-09-2015', :ends => '16-10-2015', :teamnumber =>'3', :teamgeneration => 0, :created_at => '20-09-2015', :projectleaders => 1, :updated_at =>'20-09-2015', :year => '2015'}
f_w[4] = {:name => 'Ruby-on-Rails', :description => 'Premier projet de développement en groupe, avec la technologie Ruby-on-Rails', :teacher => 'Kora', :begins => '25-09-2016', :ends => '25-10-2016', :teamnumber =>'3', :teamgeneration => 0, :created_at => '25-09-2016', :updated_at =>'25-09-2016', :projectleaders => 1, :year => '2016'}
f_w[5] = {:name => 'Ruby-on-Rails', :description => 'Premier projet de développement en groupe, avec la technologie Ruby-on-Rails', :teacher => 'Kora', :begins => '25-09-2015', :ends => '25-10-2015', :teamnumber =>'3', :teamgeneration => 0, :created_at => '25-09-2015', :updated_at =>'25-09-2015', :projectleaders => 1, :year => '2015'}
f_w[6] = {:name => 'Final Fantasy', :description => 'Créer Final Fantasy dans ta console en C#', :teacher => 'Greg', :begins => '02-11-2016', :ends => '10-11-2016', :teamnumber =>'19', :teamgeneration => 1, :created_at => '02-11-2016', :updated_at =>'02-11-2016', :projectleaders => 0, :year => '2016'}
f_w.each do |workshop|
  users_count = User.count
  creator = User.limit(1).offset(rand(users_count)).first
  workshop = Workshop.create!({:year => workshop[:year] ,:name => workshop[:name], :description => workshop[:description], :user_id => creator.id, :teacher => workshop[:teacher], :begins => workshop[:begins], :ends => workshop[:ends], :teamnumber => workshop[:teamnumber], :teamgeneration => workshop[:teamgeneration], :created_at => workshop[:created_at], :updated_at =>workshop[:updated_at], :projectleaders => workshop[:projectleaders]})
  workshop.save
  workshop[:teamnumber].times do |i|
    workshop.projects.create!({ name: workshop.name + '_#'+ i.to_s, description: workshop.description + '_#'+ i.to_s, created_at: workshop[:created_at], updated_at: workshop[:updated_at] })
  end
  i = 0
  workshop.projects.each do |project|
    offset = i * 3
    project.users = User.limit(3).offset(offset)
    Work.last.update_attribute :project_leader, 1
    i = i + 1
  end
end
