using System;
using System.ServiceModel;
using Microsoft.Practices.Unity;

namespace Unity.Wcf
{
    public class UnityInstanceContextExtension : IExtension<InstanceContext>
    {
        private IUnityContainer _childContainer;

        public IUnityContainer GetChildContainer(IUnityContainer container)
        {
            if (container == null)
            {
                throw new ArgumentNullException(nameof(container));
            }

            return _childContainer ?? (_childContainer = container.CreateChildContainer());
        }

        public void DisposeOfChildContainer()
        {
            _childContainer?.Dispose();
        }

        public void Attach(InstanceContext owner)
        {            
        }

        public void Detach(InstanceContext owner)
        {            
        }        
    }
}
