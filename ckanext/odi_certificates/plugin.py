import ckan.plugins as plugins
import ckan.plugins.toolkit as toolkit
import ckan.lib.helpers as helpers
from ckan.common import config
import json
import urllib


def certificate_api_urls():
    '''Return the certificate_img_url and certificate_link_url API urls as a JSON object string.

    :rtype: string

    '''
    certificate_base_url = config.get('ckan.odi_certificates.certificate_base_url')
    dataset_base_url = config.get('ckan.odi_certificates.dataset_base_url')
    dataset_Url = dataset_base_url + helpers.current_url()
    certificate_img_query_paramaters = json.loads(config.get('ckan.odi_certificates.certificate_img_query_paramaters'))
    certificate_img_query_paramaters['datasetUrl'] = dataset_Url
    certificate_link_query_paramaters = json.loads(config.get('ckan.odi_certificates.certificate_link_query_paramaters'))
    certificate_link_query_paramaters['datasetUrl'] = dataset_Url
  
    certificate_img_url = certificate_base_url + urllib.urlencode(certificate_img_query_paramaters)
    certificate_link_url = certificate_base_url + urllib.urlencode(certificate_link_query_paramaters)

    return json.dumps({"certificate_img_url":certificate_img_url,"certificate_link_url":certificate_link_url})


class ODICertificatesPlugin(plugins.SingletonPlugin):
    plugins.implements(plugins.IConfigurer)
    # Declare that this plugin will implement ITemplateHelpers.
    plugins.implements(plugins.ITemplateHelpers)

    # IConfigurer

    def update_config(self, config_):
        toolkit.add_template_directory(config_, 'templates')
        toolkit.add_public_directory(config_, 'public')
        toolkit.add_resource('fanstatic', 'odi_certificates')

    def get_helpers(self):
        '''Register the full_dataset_url() function above as a template
        helper function.

        '''
        # Template helper function names should begin with the name of the
        # extension they belong to, to avoid clashing with functions from
        # other extensions.
        return {'odi_certificates_certificate_api_urls': certificate_api_urls}
