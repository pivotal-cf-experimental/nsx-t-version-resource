# nsx-t-version-resource

A [Concourse](http://concourse-ci.org/)
[resource](http://concourse-ci.org/resources.html) to extract the version number
of a VMware NSX-T manager. Useful when recording the version number in Concourse
for consumption by a compatibility matrix (e.g. <http://pas-nsx-t.cfapps.io/>)


## Configuration

 * **`url`** - the NSX-T manager URL, e.g. `https://nsx.example.com`
 * **`password`** - the password to authenticate requests made to the NSX-T
   Manager, e.g. `my-super-secret-password`
 * `user` - the user used to authenticate requests made to the NSX-T Manager (default: `admin`)
 * `verify_ssl` - validate the certificate on the NSX-T Manager (default:
   `true`).
 * `cert` - the certificate of the NSX-T Manager, or the CA
   certificate used to sign the NSX-T Manager's certificate. (e.g. `-----BEGIN
   CERTIFICATE -----`). Not necessary for commercial CA-issued certificates.
   Specifying the `cert` overrides the `verify_ssl` parameter, forcing SSL
   verification.

## Behavior

### `check`

Retrieves the version number of the NSX-T manager (e.g. `2.3.0.0.0.10085361`).

### `in`

Blindly echoes the version number passed in by the `check` step, above.

### `out`

No-op (not typically used).

## Example

```yaml
---
jobs:
  - name: unit-tests
    plan:
      - get: repo
        trigger: true
      - get: nsx-t-version
resource_types:
  - name: nsx-t-version
    type: docker-image
    source:
      repository: pasnsxt/nsx-t-version
      tag: latest
resources:
  - name: nsx-t-version
    type: nsx-t-version
    source:
      url: https://nsx.example.com
      password: ((nsx_t_password))
      cert: |
        -----BEGIN CERTIFICATE-----
        MIIDujCCAqKgAwIBAgIGAWah9LQuMA0GCSqGSIb3DQEBCwUAMIGdMSowKAYDVQQD
        ...
```

## Local Testing
To test the functionality of the `check` or `in`, simply pass-in the asset file
in your shell.

For example:

```bash
bin/check < assets/check.json
```
will produce output similar to the following:
```json
[{"version":"2.3.0.0.0.10085361"}]
```

Or:

```bash
bin/in < assets/check.json
```
will produce output similar to the following:
```json
{
  "version": {
    "version": "2.2.0.0.0.8680778"
  },
  "metadata": []
}
```

## References

 * [Resources (concourse-ci.org)](https://concourse-ci.org/resources.html)

## License

[Apache License](./LICENSE)
