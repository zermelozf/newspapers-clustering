# Running the notebooks

### Install a python 3 environment

You can use virtualenv or [anaconda](https://conda.io/docs/py2or3.html), as long as you have a py3 version installed.

### Install Jupyter notebook

You can follow the instructions here: http://jupyter.readthedocs.io/en/latest/install.html

## Download the training & test data

Download https://console.aws.amazon.com/s3/object/newsclustering/filtered-csv/newsclust.csv?region=us-east-1&tab=overview and place the CSV file under data/source/newsclust.csv

### Packages required for `Report.ipynb`

```shell
pip install jupyter
pip install scikit-learn
pip install -U spacy
pip install plotly
pip install matplotlib
pip install pandas
```

Once the packages have been installed, you can launch the notebook interface using `jupyter notebook` and navigate to the `python-script` directory.

### Additional packages required for `linear-model-doc2vec.ipynb, nn-classifer-xyz.ipynb`

```shell
pip install --upgrade tensorflow
pip install keras
```

For pytorch, please see install instructions: http://pytorch.org/