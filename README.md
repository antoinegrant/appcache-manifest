# AppCache Manifest #

This gem requires Rails >= 3.2.

## Configurations

In config/routes.rb initiate the ``` Appcache::Manifest.new``` inside the routes.draw block, like so:

``` ruby
YourApp::Application.routes.draw do
    Appcache::Manifest.new
end
```

#### The default are: ####
<table>
  <tbody>
    <tr>
      <th>Variables</th>
      <th>Values</th>
    </tr>
    <tr>
      <td>version</td>
      <td>nil</td>
    </tr>
    <tr>
      <td>network</td>
      <td>['*']</td>
    </tr>
    <tr>
      <td>fallback</td>
      <td>[]</td>
    </tr>
    <tr>
      <td>manifest_url</td>
      <td>'/application.manifest'</td>
    </tr>
    <tr>
      <td>files</td>
      <td>[]</td>
    </tr>
    <tr>
      <td>include_asset_pipeline_manifest_yaml</td>
      <td>true</td>
    </tr>
  </tbody>
</table>

#### Configure inside the block ####
``` ruby
YourApp::Application.routes.draw do
  Appcache::Manifest.configure do
    config.version = Rails.application.config.assets.version
    files = Dir['public/assets/images/**/*']
    for file in files
      config.files << file.gsub('public','') if Pathname.new(file).file?
    end
    config.files << "/assets/my_custom.css"
  end
end
```