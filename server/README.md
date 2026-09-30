# Compilar el servidor

La clave del servidor se define en `lib/server_api_key.dart` y no debe
subirse al repositorio.

Desde la carpeta `server`:

```bash
dart_frog build

dart build cli \
	--target=bin/server.dart \
	--output=../builds/gamepad_server/output \
	--verbosity=error
```
	
El resultado queda en:

```text
builds/dev/gamepad_server/output/bundle/bin/server
builds/dev/gamepad_server/output/bundle/lib/libvirtual_device.so
```

Hay que distribuir ambos archivos manteniendo la estructura `bundle/`. Para
probarlo localmente:

```bash
cd builds/dev/gamepad_server
PORT=8080 ./bundle/bin/server
```

`dart compile exe` no debe usarse para este servidor porque no empaqueta
correctamente el asset nativo de `virtual_device`.
