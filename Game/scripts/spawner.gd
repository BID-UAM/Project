extends Node2D

class_name Spawner

class SpawnTimer extends Timer:
	var count:     int   = 0
	var max:       int   = 0
	var wait:      float = 0
	var dev:       float = 0
	var spawn_num: int   = 0
	var spawn_dev: int   = 0
	var item_class       = null
	var rng              = null

	func _init(item_class, max, wait, dev=0, spawn_num=1, spawn_dev=0):
		""" Temporizador que spawnea entidades en un intervalo
		
		item_class: Clase(s) de entidad a spawnear
		max: Máximo de entidades a spawnear
		wait: Tiempo a esperar entre spawns
		dev: Variación temporal aleatoria restada/sumada al wait
		spawn_num: Número de entidades spawneadas por intervalo
		spawn_dev: Variación en el número de entidades spawneadas
		"""
		self.max = max
		self.wait = wait
		self.dev = dev
		self.spawn_num = spawn_num
		self.spawn_dev = spawn_dev
		self.item_class = item_class
		self.rng = RandomNumberGenerator.new()
		self.timeout.connect(self.spawn)
		self.one_shot = true

	func start_timer():
		var final_wait = self.wait + self.rng.randf_range(-self.dev, self.dev)
		self.start(final_wait)

	func spawn():
		if self.count < self.max:
			var final_spawn = self.spawn_num + self.rng.randi_range(-self.spawn_dev, self.spawn_dev)
			final_spawn = min(final_spawn, self.max - self.count)
			for i in final_spawn:
				self.add_item()
			self.count += final_spawn
		self.start_timer()

	func add_item():
		var instance
		if self.item_class is Array:
			instance = self.item_class[randi() % self.item_class.size()].instantiate()
		else:
			instance = self.item_class.instantiate()
		instance.tree_exited.connect(self.item_freed)
		add_child(instance)

	func item_freed():
		self.count -= 1


func await_sleep(time):
	await get_tree().create_timer(time).timeout
