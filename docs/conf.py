"""
Shared Sphinx configuration using sphinx-multiproject.

To build each project, the ``PROJECT`` environment variable is used.

.. code:: console

   $ make html  # build default project
   $ PROJECT=dev make html  # build the dev project

for more information read https://sphinx-multiproject.readthedocs.io/.
"""

import os
import sys

from multiproject.utils import get_project

sys.path.append(os.path.abspath("_ext"))
extensions = [
    "hoverxref.extension",
    "multiproject",
    "myst_parser",
    "notfound.extension",
    "sphinx_copybutton",
    "sphinx_design",
    "sphinx_search.extension",
    "sphinx_tabs.tabs",
    "sphinx-prompt",
    "sphinx.ext.autodoc",
    "sphinx.ext.autosectionlabel",
    "sphinx.ext.extlinks",
    "sphinx.ext.intersphinx",
    "sphinxcontrib.httpdomain",
    "sphinxcontrib.video",
    "sphinxemoji.sphinxemoji",
    "sphinxext.opengraph",
]

multiproject_projects = {
    "user": {
        "use_config_file": False,
        "config": {
            "project": "Read the Docs user documentation",
            "html_title": "Read the Docs user documentation",
        },
    },
    "dev": {
        "use_config_file": False,
        "config": {
            "project": "Read the Docs developer documentation",
            "html_title": "Read the Docs developer documentation",
        },
    },
}

docset = get_project(multiproject_projects)

ogp_site_name = "aha Read the Docs Documentation"
