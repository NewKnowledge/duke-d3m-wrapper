from distutils.core import setup

setup(name='DukeD3MWrapper',
    version='1.2.0',
    description='A wrapper for integrating Duke into the D3M environment',
    packages=['DukeD3MWrapper'],
    install_requires=["numpy==1.17.3",
        "requests==2.22.0",
        "typing",
        "Duke @ git+https://github.com/NewKnowledge/duke@c56416e959b52ff5077c5a54c329e2f6e83bbd97#egg=Duke-1.2.0"],
    entry_points = {
        'd3m.primitives': [
            'data_cleaning.text_summarization.Duke = DukeD3MWrapper:duke'
        ],
    },
)
