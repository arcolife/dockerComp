from app import db
    

class Config(db.EmbeddedDocument):
    container_ip_addr = db.StringField(max_length=30,
                                required=True)
    docker_inspect = db.DictField()


class Container(db.EmbeddedDocument):
    # container_id = db.StringField(max_length=20, 
    #                               unique=True,
    #                               required=True)

    # pool_id = db.StringField(max_length=30,
    #                          required=True)
    container_name = db.StringField()
    data_received = db.ListField()
    data_sent = db.IntField()
    time_sent = db.DateTimeField()
    time_received = db.DateTimeField()
    config =  db.EmbeddedDocumentField(Config)


class Client(db.Document):
    """ 
    @containers:    {'<container_id' : <Object(Container)>}

    @ip_addr:    Client's IP Address 
    (to track multiple containers on same client)

    """
    containers = db.DictField()
    ip_addr = db.StringField(max_length=30,
                             unique=True)

    
class Server(db.Document):
    """
    @connected_pools: 
    1 pool(client) is a group of containers having same IP addr.
    { 'client_IP' : [Container_IDs] }
    
    @client_result:    { 'client_IP' : <int> }

    @client_data:    { 'client_IP' : <list> }    

    """
    connected_clients = db.DictField()
    client_data = db.DictField()
    client_result = db.DictField()
    
