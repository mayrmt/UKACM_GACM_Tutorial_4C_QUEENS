# VirtualBox Setup

The following steps are required to finish the VirtualBox setup for the workshop.

## 4C

In the virtual box most things are already set up. So let's us clone the tutorials

```bash
git clone https://github.com/mayrmt/UKACM_GACM_Tutorial_4C_QUEENS.git
```

The tutorials can now be found in `/home/participant/UKACM_GACM_Tutorial_4C_QUEENS`.

## QUEENS

For the QUEENS tutorials, we need to create a Python enviroment with QUEENS install in it.

## 1. Create a Python environment
Create a conda environment using:
```bash
conda create -n queens python==3.11
```

Now let's activate the enviroment by:
```bash
conda activate queens
```

## 2. Install QUEENS
Afterwards navigate to the QUEENS source

```bash
cd /home/participant/queens
```

and install QUEENS via

```bash
pip install -e .
```

## 3. Install Jupyter
We use Jupyter notebooks for the interactivate QUEENS tutorials. So let's install the required packages:

```bash
cd /home/participant/UKACM_GACM_Tutorial_4C_QUEENS
pip install -r additional_requirements.txt
```

## 4. Run the jupyter notebooks
We are now ready to go. Start Jupyter by
```bash
jupyter notebook
```

This should open a page in the web browser. Open the tutorials under
```
/home/participant/UKACM_GACM_Tutorial_4C_QUEENS/QUEENS/0-setup/0-setup.ipynb
```

