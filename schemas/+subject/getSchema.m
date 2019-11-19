function obj = getSchema
prefix = getenv('DB_PREFIX');
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'subject', [prefix 'subject']);
end
obj = schemaObject;
end
